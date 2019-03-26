From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 26 Mar 2019 15:21:41 -0700
Subject: [Intel-wired-lan] [PATCH] net: fm10k: fix a potential NULL
 pointer dereference
In-Reply-To: <FA2DD268-9578-49B5-8E9E-D3FA8C9AEDFC@umn.edu>
References: <20190311061732.19064-1-kjlu@umn.edu>
 <FA2DD268-9578-49B5-8E9E-D3FA8C9AEDFC@umn.edu>
Message-ID: <5bf2a409fb5f3fbb44ac3eda591ba0cbc6122d44.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-03-22 at 22:26 -0500, Kangjie Lu wrote:
> > On Mar 11, 2019, at 1:17 AM, Kangjie Lu <kjlu@umn.edu> wrote:
> > 
> > In case alloc_workqueue fails, the fix returns -ENOMEM to avoid
> > potential NULL pointer dereference.
> > 
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> > drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > index 5a0419421511..215f232674f1 100644
> > --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > @@ -41,6 +41,8 @@ static int __init fm10k_init_module(void)
> > 	/* create driver workqueue */
> > 	fm10k_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
> > 					  fm10k_driver_name);
> > +	if (unlikely(!fm10k_workqueue))
> > +		return -ENOMEM;
> > 
> 
> Jeff, can you review this patch?

Yep, sorry for the delay in getting back to you.  I already had this
change in my tree queued up from Yue Haibing.  I am actually preparing
to push this fix and few others to Dave in a couple of hours.

> 
> > 	fm10k_dbg_init();
> > 
> > -- 
> > 2.17.1
> > 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190326/56e908f9/attachment.asc>
