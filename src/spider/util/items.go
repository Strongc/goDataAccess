package util

type Items struct {
	items map[string]string
}

func NewItems() *Items {
	return (&Items{}).init()
}

func (this *Items) Set(key string, value string) {
	this.items[key] = value
}

func (this *Items) Get(key string, defaultVal string) string {
	if val, ok := this.items[key]; ok {
		return val
	}
	return defaultVal
}

func (this *Items) GetAll() map[string]string {
	return this.items
}

func (this *Items) init() *Items {
	this.items = make(map[string]string)
	return this
}
