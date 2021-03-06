package store

import (
	"testing"
)

func Test_1(t *testing.T) {
	vs := NewVersionedStore(1)

	a := NewBlob(1)
	b := NewBlob(1)

	a.Data[0] = 1
	b.Data[0] = 2

	vs.Create("0xff", "a.idx", a)
	if err := vs.Create("0xff", "a.idx", a); err == nil {
		t.Error("Create should return error")
	}

	if err := vs.Get("0x00", "a.idx", &b); err == nil {
		t.Error("Get should return error")
	}
	vs.Get("0xff", "a.idx", &b)

	if b.Data[0] != 1 {
		t.Error("Get failed")
	}

	vs.Create("0x100", "a.idx", a)
	if err := vs.Get("0xff", "a.idx", &b); err == nil {
		t.Error("Get should return error")
	}
}
