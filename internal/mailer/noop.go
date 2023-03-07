package mailer

import (
	"errors"
)

type noopMailClient struct{}

func (m *noopMailClient) Mail(to, subjectTemplate, templateURL, defaultTemplate string, templateData map[string]interface{}) error {
	if to == "" {
		return errors.New("to field cannot be empty")
	}
	return nil
}
func (m *noopMailClient) MailWithAlternative(to, subjectTemplate, templateURL, defaultTemplate string, plainTemplateUrl string, plainDefaultTemplate string, templateData map[string]interface{}) error {
	if to == "" {
		return errors.New("to field cannot be empty")
	}
	return nil
}
