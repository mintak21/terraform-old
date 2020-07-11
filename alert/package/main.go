package main

import (
	"context"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ssm"
	"github.com/kelseyhightower/envconfig"
	log "github.com/sirupsen/logrus"
	"github.com/slack-go/slack"
)

// 事前準備
// 1. https://api.slack.com/apps/ より、chat.write/chat.write.customizeスコープでアプリ作成&OAuthトークンを発行
// 2. 1のトークンをSSMに格納
// 3. 1のアプリを通知するチャンネルへ招待

var conf config

type config struct {
	TokenSsmParameterName string `envconfig:"token_parameter_name" required:"true" default:"alert_notify_slack_token"`
	NotificationChannel   string `envconfig:"notification_channel" required:"true"`
	NotifyUserName        string `default:"AWS Billing Alert Bot"`
	NotifyIcon            string `default:":lightning_cloud:"`
	Region                string `default:"ap-northeast-1"`
}

// HandleRequest handle SNSEvent Request
func HandleRequest(ctx context.Context, event events.SNSEvent) (string, error) {
	log.Info("start handle request")
	log.WithFields(log.Fields{
		"topicArn": event.Records[0].SNS.TopicArn,
		"subscArn": event.Records[0].EventSubscriptionArn,
		"type":     event.Records[0].SNS.Type,
	}).Info("Recieved Event")
	err := postMessages(event.Records[0].SNS.Message)
	return "end handle request", err
}

func postMessages(message string) error {
	token, err := slackToken()
	if err != nil {
		log.WithError(err)
		return err
	}
	client := slack.New(token)
	_, _, err = client.PostMessage(conf.NotificationChannel,
		slack.MsgOptionText(message, false),
		slack.MsgOptionUsername(conf.NotifyUserName),
		slack.MsgOptionIconEmoji(conf.NotifyIcon))
	return err
}

func slackToken() (string, error) {
	svc := ssm.New(session.New(), &aws.Config{
		Region: aws.String(conf.Region),
	})
	param, err := svc.GetParameter(&ssm.GetParameterInput{
		Name:           aws.String(conf.TokenSsmParameterName),
		WithDecryption: aws.Bool(true),
	})
	if err != nil {
		return "", err
	}
	log.WithFields(log.Fields{
		"parameterName": conf.TokenSsmParameterName,
		"region":        conf.Region,
	}).Info("successed get ssm parameter")
	return *param.Parameter.Value, nil
}

func init() {
	// logging settings
	log.SetFormatter(&log.JSONFormatter{})
	log.SetOutput(os.Stdout)
	log.SetLevel(log.InfoLevel)
	// configuration loads
	if err := envconfig.Process("", &conf); err != nil {
		log.WithFields(log.Fields{
			"err": err.Error(),
		}).Fatal("Failed to process env")
	}
	log.Println("config : ", conf)
}

func main() {
	lambda.Start(HandleRequest)
}
