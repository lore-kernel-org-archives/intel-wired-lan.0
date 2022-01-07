From: John Garry <john.garry@huawei.com>
Date: Fri, 7 Jan 2022 17:16:23 +0000
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <20220106181409.GA297735@bhelgaas>
References: <20220106181409.GA297735@bhelgaas>
Message-ID: <b0e772ed-4c21-3d5a-d890-aba05c41904c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/01/2022 18:14, Bjorn Helgaas wrote:
>> That driver would prob not be used on systems which does not support PIO,
>> and so could have a HAS_IOPORT dependency. But it is not strictly necessary.
> I don't want the path of "this driver isn't needed because the device
> is unlikely to be used on this arch."

Sure, that was just a one off example. As I mentioned before, I think 
that Arnd already did most of the ifdeffery work, but it was not 
included in this series.

> 
> Maybe it's not_always_  possible, but if the device can be plugged
> into the platform, I think we should be able to build the driver for
> it.
> 
> If the device requires I/O port space and the platform doesn't support
> it, the PCI core or the driver should detect that and give a useful
> diagnostic.
> 

I'm not sure what the driver can say apart from -ENODEV. Or IO port 
management in resource.c could warn for requesting IO port region when 
it's unsupported.

Anyway, this same conversion was had with Linus before I got involved. 
If you think it is worth discussing again then I suppose the authors 
here need to gain consensus.

Thanks,
John
