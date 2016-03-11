From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 11 Mar 2016 00:01:15 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v3] fm10k: Avoid crashing
 the	kernel
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99CCBD@ORSMSX104.amr.corp.intel.com>
References: <20160309202557.137597.51678.stgit@bwallan-cwp1.jf.intel.com>
 <804857E1F29AAC47BF68C404FC60A18490D8AC61@ORSMSX105.amr.corp.intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99CCBD@ORSMSX104.amr.corp.intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A18490D8C86B@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Bowers, AndrewX
> Sent: Thursday, March 10, 2016 10:35 AM
> To: Allan, Bruce W <bruce.w.allan@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: RE: [Intel-wired-lan] [next-queue PATCH v3] fm10k: Avoid crashing
> the kernel
> 
> 
> No idea why this is the case, but with this patch applied I can't pass traffic
> over i40e devices. Revert the patch and I can pass traffic just fine.
> 
> I don't know why it'd affect it though, I don't even have any fm10k devices
> in my system (I do have an ixgbe card)

Issue with i40e cannot be related to this patch...there must be another explanation.

