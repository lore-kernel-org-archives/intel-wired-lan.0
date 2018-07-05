From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Thu, 5 Jul 2018 23:12:17 +0000
Subject: [Intel-wired-lan] [intel-linux] Intel NIC modules completely
 broken on latest Debian testing netinst image
In-Reply-To: <804857E1F29AAC47BF68C404FC60A184F238184F@ORSMSX105.amr.corp.intel.com>
References: <153080837248.9232.10678479507731033079@cacraft-MOBL>
 <804857E1F29AAC47BF68C404FC60A184F238184F@ORSMSX105.amr.corp.intel.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD69A43F701@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We don't support Debian and they've been having issues with our drivers lately. I bet if you boot off of an Ubuntu live disk things will be fine.

I've just seen Debian picking problematic kernels quite often. You can also try any stable kernel from kernel.org as well.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Allan, Bruce W
Sent: Thursday, July 5, 2018 9:43 AM
To: Craft, Clayton A <clayton.a.craft@intel.com>; intel-linux at eclists.intel.com
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [intel-linux] Intel NIC modules completely broken on latest Debian testing netinst image

Cc'ing the mailing list that Intel wired Ethernet developers watch, i.e. intel-wired-lan at lists.osuosl.org

> -----Original Message-----
> From: intel-linux-request at eclists.intel.com [mailto:intel-linux- 
> request at eclists.intel.com] On Behalf Of Craft, Clayton A
> Sent: Thursday, July 05, 2018 9:33 AM
> To: intel-linux at eclists.intel.com
> Subject: [intel-linux] Intel NIC modules completely broken on latest 
> Debian testing netinst image
> 
> I've encountered an unusual issue when trying to use the latest Debian 
> testing netinst images on platforms with Intel NICs that use igb, 
> igbe, ixgbe, and e1000e modules (possibly others, though I didn't 
> check). The modules do not load in the 4.16 kernel on the image, even 
> though their magic ver matches the running kernel.
> 
> I reported the issue upstream to Debian 
> (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=903047), but this 
> seems substantial enough that I think the linux NIC driver developers, 
> whoever they are, should also be aware of this in case it's a bug in 
> the driver and not with how Debian is building/constructing their 
> install image. We are currently using debian testing in our CI, and 
> this blocks our ability to build/deploy new tester systems :(
> 
> Does anyone know how to forward this on to the right folks @ Intel?
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
