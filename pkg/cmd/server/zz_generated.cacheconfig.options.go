// Code generated by github.com/ecordell/optgen. DO NOT EDIT.
package server

import (
	defaults "github.com/creasty/defaults"
	helpers "github.com/ecordell/optgen/helpers"
)

type CacheConfigOption func(c *CacheConfig)

// NewCacheConfigWithOptions creates a new CacheConfig with the passed in options set
func NewCacheConfigWithOptions(opts ...CacheConfigOption) *CacheConfig {
	c := &CacheConfig{}
	for _, o := range opts {
		o(c)
	}
	return c
}

// NewCacheConfigWithOptionsAndDefaults creates a new CacheConfig with the passed in options set starting from the defaults
func NewCacheConfigWithOptionsAndDefaults(opts ...CacheConfigOption) *CacheConfig {
	c := &CacheConfig{}
	defaults.MustSet(c)
	for _, o := range opts {
		o(c)
	}
	return c
}

// ToOption returns a new CacheConfigOption that sets the values from the passed in CacheConfig
func (c *CacheConfig) ToOption() CacheConfigOption {
	return func(to *CacheConfig) {
		to.Name = c.Name
		to.MaxCost = c.MaxCost
		to.NumCounters = c.NumCounters
		to.Metrics = c.Metrics
		to.Enabled = c.Enabled
		to.defaultTTL = c.defaultTTL
	}
}

// DebugMap returns a map form of CacheConfig for debugging
func (c CacheConfig) DebugMap() map[string]any {
	debugMap := map[string]any{}
	debugMap["Name"] = helpers.DebugValue(c.Name, false)
	debugMap["MaxCost"] = helpers.DebugValue(c.MaxCost, false)
	debugMap["NumCounters"] = helpers.DebugValue(c.NumCounters, false)
	debugMap["Metrics"] = helpers.DebugValue(c.Metrics, false)
	debugMap["Enabled"] = helpers.DebugValue(c.Enabled, false)
	return debugMap
}

// CacheConfigWithOptions configures an existing CacheConfig with the passed in options set
func CacheConfigWithOptions(c *CacheConfig, opts ...CacheConfigOption) *CacheConfig {
	for _, o := range opts {
		o(c)
	}
	return c
}

// WithOptions configures the receiver CacheConfig with the passed in options set
func (c *CacheConfig) WithOptions(opts ...CacheConfigOption) *CacheConfig {
	for _, o := range opts {
		o(c)
	}
	return c
}

// WithName returns an option that can set Name on a CacheConfig
func WithName(name string) CacheConfigOption {
	return func(c *CacheConfig) {
		c.Name = name
	}
}

// WithMaxCost returns an option that can set MaxCost on a CacheConfig
func WithMaxCost(maxCost string) CacheConfigOption {
	return func(c *CacheConfig) {
		c.MaxCost = maxCost
	}
}

// WithNumCounters returns an option that can set NumCounters on a CacheConfig
func WithNumCounters(numCounters int64) CacheConfigOption {
	return func(c *CacheConfig) {
		c.NumCounters = numCounters
	}
}

// WithMetrics returns an option that can set Metrics on a CacheConfig
func WithMetrics(metrics bool) CacheConfigOption {
	return func(c *CacheConfig) {
		c.Metrics = metrics
	}
}

// WithEnabled returns an option that can set Enabled on a CacheConfig
func WithEnabled(enabled bool) CacheConfigOption {
	return func(c *CacheConfig) {
		c.Enabled = enabled
	}
}
