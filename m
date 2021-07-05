From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 5 Jul 2021 09:12:36 +0200
Subject: [Intel-wired-lan] Cherry-pick "i40e: Be much more verbose about
 what we can and cannot offload"
In-Reply-To: <BYAPR11MB360618A581F56D9054B2148AEF029@BYAPR11MB3606.namprd11.prod.outlook.com>
References: <937dd880-f902-aa9c-67d5-2d582a29e122@univention.de>
 <BYAPR11MB360618A581F56D9054B2148AEF029@BYAPR11MB3606.namprd11.prod.outlook.com>
Message-ID: <YOKw5MzGaUNjxx/y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 29, 2021 at 06:20:30PM +0000, Fujinaka, Todd wrote:
> I think I accidentally deleted the forward from the intel-wired-lan spam filter. Re-forwarding and adding Alex's gmail address.
> 
> Also, 
> 
> Todd Fujinaka
> Software Application Engineer
> Data Center Group
> Intel Corporation
> todd.fujinaka at intel.com
> 
> -----Original Message-----
> From: Philipp Hahn <hahn@univention.de> 
> Sent: Tuesday, June 22, 2021 11:19 AM
> To: stable at vger.kernel.org; 892105 at bugs.debian.org; Ben Hutchings <benh@debian.org>
> Cc: Alexander Duyck <alexander.h.duyck@intel.com>; Andrew Bowers <andrewx.bowers@intel.com>; Bonaccorso, Salvatore <carnil@debian.org>
> Subject: Cherry-pick "i40e: Be much more verbose about what we can and cannot offload"
> 
> Hello,
> 
> I request the following patch from v4.10-rc1 to get cherry-picked into
> "stable/linux-4.9.y":
> 
> > commit f114dca2533ca770aebebffb5ed56e5e7d1fb3fb

Please provide a working backport, that you have tested works properly,
as it does not apply cleanly.

thanks,

greg k-h
