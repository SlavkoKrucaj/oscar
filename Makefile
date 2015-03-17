SCHEME = oscar
TARGET = target

OSCAR = $(TARGET)/oscar

default: build

build:
	mkdir -p $(TARGET)
	xcodebuild -scheme $(SCHEME) DSTROOT=$(TARGET) DEPLOYMENT_LOCATION=YES INSTALL_PATH=/ 

clean:
	rm -rf $(TARGET)
	xcodebuild -scheme $(SCHEME) clean
