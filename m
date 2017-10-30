From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Oct 2017 18:59:01 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 1/6] net:
 sched: Identify hardware traffic classes using classid
In-Reply-To: <150909693494.48377.7265505471193257120.stgit@anamdev.jf.intel.com>
References: <150909628755.48377.16561267691881106259.stgit@anamdev.jf.intel.com>
 <150909693494.48377.7265505471193257120.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADB74@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Friday, October 27, 2017 2:36 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: jiri at resnulli.us; netdev at vger.kernel.org; jhs at mojatatu.com;
> xiyou.wangcong at gmail.com
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 1/6] net: sched:
> Identify hardware traffic classes using classid
> 
> This patch offloads the classid to hardware and uses the classid reserved in
> the range :ffe0 - :ffef to identify hardware traffic classes reported via dev-
> >num_tc.
> 
> tcf_result structure contains the class ID of the class to which the packet
> belongs and is offloaded to hardware via flower filter.
> A new helper function is introduced to represent HW traffic classes 0 through
> 15 using the reserved classid values :ffe0 - :ffef.
> 
> v5: Added helper function to get HW TC values from classid.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  include/net/pkt_cls.h     |    1 +
>  include/net/sch_generic.h |    7 +++++++
>  net/sched/cls_flower.c    |    2 ++
>  3 files changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


