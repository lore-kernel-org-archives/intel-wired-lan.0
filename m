From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 4 May 2017 20:25:24 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix pf-flags overwrite bug
 introduced in hw_disabled_flags removal patch.
In-Reply-To: <CAKgT0UeXCCOBLsH9xGJehyLvYP07z28tKMwKC-LfdH==kjrZng@mail.gmail.com>
References: <1493923609-15708-1-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0UeXCCOBLsH9xGJehyLvYP07z28tKMwKC-LfdH==kjrZng@mail.gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857E20AB7@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Thursday, May 04, 2017 12:53 PM
> To: Samudrala, Sridhar <sridhar.samudrala@intel.com>
> Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH] i40e: Fix pf-flags overwrite bug introduced
> in hw_disabled_flags removal patch.
> 
> This needs to be pushed ASAP for Dave's net tree as without it we are
> losing MSI, MSI-X and all basic offloads for the X710 and XL710 parts.
> 
> Feel free to add the following:
> Fixes: 47994c119a36 ("i40e: remove hw_disabled_flags in favor of using
> separate flag bits")
> Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
> 

Please add

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

This regression was introduced because the upstream code base was not identical and some of the code changes did not get properly redone for the upstream. Thanks for catching this and I apologize that I failed to catch this during review.

Thanks,
Jake
