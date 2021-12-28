From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 28 Dec 2021 09:21:23 +0100
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <20211227164317.4146918-2-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-2-schnelle@linux.ibm.com>
Message-ID: <YcrJAwsKIxxX18pW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 27, 2021 at 05:42:46PM +0100, Niklas Schnelle wrote:
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -23,6 +23,17 @@ menuconfig PCI
>  
>  if PCI
>  
> +config LEGACY_PCI
> +	bool "Enable support for legacy PCI devices"
> +	depends on HAVE_PCI
> +	help
> +	   This option enables support for legacy PCI devices. This includes
> +	   PCI devices attached directly or via a bridge on a PCI Express bus.
> +	   It also includes compatibility features on PCI Express devices which
> +	   make use of legacy I/O spaces.

All you really care about is the "legacy" I/O spaces here, this isn't
tied to PCI specifically at all, right?

So why not just have a OLD_STYLE_IO config option or something like
that, to show that it's the i/o functions we care about here, not PCI at
all?

And maybe not call it "old" or "legacy" as time constantly goes forward,
just describe it as it is, "DIRECT_IO"?

thanks,

greg k-h
