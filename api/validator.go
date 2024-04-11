package api

import (
	"bank/utils"
	"github.com/go-playground/validator/v10"
)

var validCurrency validator.Func = func(fieldLever validator.FieldLevel) bool {
	if currency, ok := fieldLever.Field().Interface().(string); ok {
		return utils.IsSupportedCurrency(currency)
	}

	return false
}
