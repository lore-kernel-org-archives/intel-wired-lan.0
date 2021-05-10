From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 10 May 2021 15:38:07 +0200
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <df6b4567-030c-a480-c5a6-fe579830e8c0@gmail.com>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
 <df6b4567-030c-a480-c5a6-fe579830e8c0@gmail.com>
Message-ID: <20210510153807.4405695e@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Mon, 10 May 2021 14:16:16 +0100
Edward Cree <ecree.xilinx@gmail.com> escreveu:

> On 10/05/2021 12:55, Mauro Carvalho Chehab wrote:
> > The main point on this series is to replace just the occurrences
> > where ASCII represents the symbol equally well  
> 
> > 	- U+2014 ('?'): EM DASH  
> Em dash is not the same thing as hyphen-minus, and the latter does not
>  serve 'equally well'.  People use em dashes because ? even in
>  monospace fonts ? they make text easier to read and comprehend, when
>  used correctly.

True, but if you look at the diff, on several places, IMHO a single
hyphen would make more sensus. Maybe those places came from a converted
doc.

> I accept that some of the other distinctions ? like en dashes ? are
>  needlessly pedantic (though I don't doubt there is someone out there
>  who will gladly defend them with the same fervour with which I argue
>  for the em dash) and I wouldn't take the trouble to use them myself;
>  but I think there is a reasonable assumption that when someone goes
>  to the effort of using a Unicode punctuation mark that is semantic
>  (rather than merely typographical), they probably had a reason for
>  doing so.
> 
> > 	- U+2018 ('?'): LEFT SINGLE QUOTATION MARK
> > 	- U+2019 ('?'): RIGHT SINGLE QUOTATION MARK
> > 	- U+201c ('?'): LEFT DOUBLE QUOTATION MARK
> > 	- U+201d ('?'): RIGHT DOUBLE QUOTATION MARK  
> (These are purely typographic, I have no problem with dumping them.)
> 
> > 	- U+00d7 ('?'): MULTIPLICATION SIGN  
> Presumably this is appearing in mathematical formulae, in which case
>  changing it to 'x' loses semantic information.
> 
> > Using the above symbols will just trick tools like grep for no good
> > reason.  
> NBSP, sure.  That one's probably an artefact of some document format
>  conversion somewhere along the line, anyway.
> But what kinds of things with ? or ? in are going to be grept for?

Actually, on almost all places, those aren't used inside math formulae, but
instead, they describe video some resolutions:

	$ git grep ? Documentation/
	Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml:title: ASUS Z00T TM5P5 NT35596 5.5" 1080?1920 LCD Panel
	Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml:        # LG ACX467AKM-7 4.95" 1080?1920 LCD Panel
	Documentation/devicetree/bindings/sound/tlv320adcx140.yaml:      1 - Mic bias is set to VREF ? 1.096
	Documentation/userspace-api/media/v4l/crop.rst:of 16 ? 16 pixels. The source cropping rectangle is set to defaults,
	Documentation/userspace-api/media/v4l/crop.rst:which are also the upper limit in this example, of 640 ? 400 pixels at
	Documentation/userspace-api/media/v4l/crop.rst:offset 0, 0. An application requests an image size of 300 ? 225 pixels,
	Documentation/userspace-api/media/v4l/crop.rst:The driver sets the image size to the closest possible values 304 ? 224,
	Documentation/userspace-api/media/v4l/crop.rst:is 608 ? 224 (224 ? 2:1 would exceed the limit 400). The offset 0, 0 is
	Documentation/userspace-api/media/v4l/crop.rst:rectangle of 608 ? 456 pixels. The present scaling factors limit
	Documentation/userspace-api/media/v4l/crop.rst:cropping to 640 ? 384, so the driver returns the cropping size 608 ? 384
	Documentation/userspace-api/media/v4l/crop.rst:and adjusts the image size to closest possible 304 ? 192.
	Documentation/userspace-api/media/v4l/diff-v4l.rst:size bitmap of 1024 ? 625 bits. Struct :c:type:`v4l2_window`
	Documentation/userspace-api/media/v4l/vidioc-cropcap.rst:       Assuming pixel aspect 1/1 this could be for example a 640 ? 480
	Documentation/userspace-api/media/v4l/vidioc-cropcap.rst:       rectangle for NTSC, a 768 ? 576 rectangle for PAL and SECAM

it is a way more likely that, if someone wants to grep, they would be 
doing something like this, in order to get video resolutions:

	$ git grep -E "\b[1-9][0-9]+\s*x\s*[0-9]+\b" Documentation/
	Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus:Description:        When read the mouse returns a 30x30 pixel image of the
	Documentation/ABI/obsolete/sysfs-driver-hid-roccat-konepure:Description:        When read the mouse returns a 30x30 pixel image of the
	Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7:               Provides access to the binary "24x7 catalog" provided by the
	Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7:               https://raw.githubusercontent.com/jmesmon/catalog-24x7/master/hv-24x7-	catalog.h
	Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7:               Exposes the "version" field of the 24x7 catalog. This is also
	Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7:               HCALLs to retrieve hv-24x7 pmu event counter data.
	Documentation/ABI/testing/sysfs-bus-vfio-mdev:          "2 heads, 512M FB, 2560x1600 maximum resolution"
	Documentation/ABI/testing/sysfs-driver-wacom:           of the device. The image is a 64x32 pixel 4-bit gray image. The
	Documentation/ABI/testing/sysfs-driver-wacom:           1024 byte binary is split up into 16x 64 byte chunks. Each 64
	Documentation/ABI/testing/sysfs-driver-wacom:           image has to contain 256 bytes (64x32 px 1 bit colour).
	Documentation/admin-guide/edid.rst:commonly used screen resolutions (800x600, 1024x768, 1280x1024, 1600x1200,
	Documentation/admin-guide/edid.rst:1680x1050, 1920x1080) as binary blobs, but the kernel source tree does
	Documentation/admin-guide/edid.rst:If you want to create your own EDID file, copy the file 1024x768.S,
	Documentation/admin-guide/kernel-parameters.txt:                        edid/1024x768.bin, edid/1280x1024.bin,
	Documentation/admin-guide/kernel-parameters.txt:                        edid/1680x1050.bin, or edid/1920x1080.bin is given
	Documentation/admin-guide/kernel-parameters.txt:                        2 - The VGA Shield is attached (1024x768)
	Documentation/admin-guide/media/dvb_intro.rst:signal encoded at a resolution of 768x576 24-bit color pixels over 25
	Documentation/admin-guide/media/imx.rst:1280x960 input frame to 640x480, and then /2 downscale in both
	Documentation/admin-guide/media/imx.rst:dimensions to 320x240 (assumes ipu1_csi0 is linked to ipu1_csi0_mux):
	Documentation/admin-guide/media/imx.rst:   media-ctl -V "'ipu1_csi0_mux':2[fmt:UYVY2X8/1280x960]"

which won't get the above, due to the usage of the UTF-8 alternative.

In any case, replacing all the above by 'x' seems to be the right thing,
at least on my eyes.

> If there are em dashes lying around that semantically _should_ be
>  hyphen-minus (one of your patches I've seen, for instance, fixes an
>  *en* dash moonlighting as the option character in an `ethtool`
>  command line), then sure, convert them.
> But any time someone is using a Unicode character to *express
>  semantics*, even if you happen to think the semantic distinction
>  involved is a pedantic or unimportant one, I think you need an
>  explicit grep case to justify ASCIIfying it.

Yeah, in the case of hyphen/dash it seems to make sense to double check
it.

Thanks,
Mauro
