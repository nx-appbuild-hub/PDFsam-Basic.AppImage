SOURCE="https://github.com/torakiki/pdfsam/releases/download/v4.1.3/pdfsam_4.1.3-1_amd64.deb"
DESTINATION="build.deb"
OUTPUT="PDFsamBasic.AppImage"


all:
	echo "Building: $(OUTPUT)"
	wget --output-document=$(DESTINATION) --continue $(SOURCE)

	dpkg -x $(DESTINATION) build
	rm -rf AppDir/opt

	mkdir --parents AppDir/application
	cp -r build/opt/pdfsam-basic/* AppDir/application
	chmod -R +x AppDir/application/runtime
	chmod -R +x AppDir/application/bin

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

	rm -f $(DESTINATION)
	rm -rf ./AppDir/application
	rm -rf ./build
