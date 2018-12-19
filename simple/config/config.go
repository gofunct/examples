package config

import (
	"github.com/spf13/viper"
)

type CookieCutter struct {
	File string
	Config 	*viper.Viper
}

func NewCookieCutterCookieCutter(appName string) *CookieCutter {
	v := viper.New()
	v.SetConfigFile("cookiecutter")
	v.SetEnvPrefix(appName)
	v.AutomaticEnv()

	// global defaults
	
	v.SetDefault("json_logs", true)
	v.SetDefault("loglevel", "debug")
	
	return &CookieCutter{
		File: "cookiecutter.json",
		Config:  v,
	}
}

func (p *CookieCutter) GetViper() *viper.Viper {
	return p.Config
}


func (p *CookieCutter) GetConfigFile() string {
	return p.File
}
