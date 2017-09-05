From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 05 Sep 2017 14:09:59 -0700
Subject: [Intel-wired-lan] [PATCH net-next] i40e: limit lan queue count
 in large cpu count machine
In-Reply-To: <c8d200bd-03a5-6293-3faf-83d0eb53c479@oracle.com>
References: <1500945462-33176-1-git-send-email-shannon.nelson@oracle.com>
 <c8d200bd-03a5-6293-3faf-83d0eb53c479@oracle.com>
Message-ID: <1504645799.3922.74.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-09-05 at 13:31 -0700, Shannon Nelson wrote:
> Hey Jeff,
> 
> Any clues on when this patch, still sitting at "Under Review", will
> get 
> moved along?

I have 15 patches ready to push to Dave, and your patch is literally
the next in line.  But the window is closing, if not closed already.  I
could try and push a series of 16 patches, but I do not want to push my
luck with Dave especially that this would be a pull request right at
the deadline of net-next closing.

Your patch does "fix" the driver, so I have no problem pushing it to
net (4.14) once Dave and Linus get done syncing their trees this week.

> 
> On 7/24/2017 6:17 PM, Shannon Nelson wrote:
> > When a machine has more cpus than queuepairs, e.g. 512 cores, the
> > counting gets a little funky and turns off Flow Director with the
> > message:
> >    not enough queues for Flow Director. Flow Director feature is
> > disabled
> > 
> > This patch limits the number of lan queues initially allocated to
> > be sure we have some left for FD and other features.
> > 
> > Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_main.c |   11 +++++++----
> >   1 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 2db93d3..a694e99 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -11059,6 +11059,7 @@ static int i40e_setup_pf_switch(struct
> > i40e_pf *pf, bool reinit)
> >   static void i40e_determine_queue_usage(struct i40e_pf *pf)
> >   {
> >   	int queues_left;
> > +	int q_max;
> >   
> >   	pf->num_lan_qps = 0;
> >   
> > @@ -11105,10 +11106,12 @@ static void
> > i40e_determine_queue_usage(struct i40e_pf *pf)
> >   					I40E_FLAG_DCB_ENABLED);
> >   			dev_info(&pf->pdev->dev, "not enough
> > queues for DCB. DCB is disabled.\n");
> >   		}
> > -		pf->num_lan_qps = max_t(int, pf->rss_size_max,
> > -					num_online_cpus());
> > -		pf->num_lan_qps = min_t(int, pf->num_lan_qps,
> > -					pf-
> > >hw.func_caps.num_tx_qp);
> > +
> > +		/* limit lan qps to the smaller of qps, cpus or
> > msix */
> > +		q_max = max_t(int, pf->rss_size_max,
> > num_online_cpus());
> > +		q_max = min_t(int, q_max, pf-
> > >hw.func_caps.num_tx_qp);
> > +		q_max = min_t(int, q_max, pf-
> > >hw.func_caps.num_msix_vectors);
> > +		pf->num_lan_qps = q_max;
> >   
> >   		queues_left -= pf->num_lan_qps;
> >   	}
> > 
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170905/7a110a1e/attachment.asc>
