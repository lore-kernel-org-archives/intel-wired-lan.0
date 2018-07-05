From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Thu, 5 Jul 2018 16:42:49 +0000
Subject: [Intel-wired-lan] [intel-linux] Intel NIC modules completely
 broken on latest Debian testing netinst image
In-Reply-To: <153080837248.9232.10678479507731033079@cacraft-MOBL>
References: <153080837248.9232.10678479507731033079@cacraft-MOBL>
Message-ID: <804857E1F29AAC47BF68C404FC60A184F238184F@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Cc'ing the mailing list that Intel wired Ethernet developers watch, i.e. intel-wired-lan at lists.osuosl.org

> -----Original Message-----
> From: intel-linux-request at eclists.intel.com [mailto:intel-linux-
> request at eclists.intel.com] On Behalf Of Craft, Clayton A
> Sent: Thursday, July 05, 2018 9:33 AM
> To: intel-linux at eclists.intel.com
> Subject: [intel-linux] Intel NIC modules completely broken on latest Debian
> testing netinst image
> 
> I've encountered an unusual issue when trying to use the latest Debian testing
> netinst images on platforms with Intel NICs that use igb, igbe, ixgbe, and
> e1000e modules (possibly others, though I didn't check). The modules do
> not load in the 4.16 kernel on the image, even though their magic ver matches
> the running kernel.
> 
> I reported the issue upstream to Debian
> (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=903047), but this seems
> substantial enough that I think the linux NIC driver developers, whoever they
> are, should also be aware of this in case it's a bug in the driver and not with
> how Debian is building/constructing their install image. We are currently using
> debian testing in our CI, and this blocks our ability to build/deploy new tester
> systems :(
> 
> Does anyone know how to forward this on to the right folks @ Intel?
