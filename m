From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 23 Jun 2017 18:30:46 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 05/10] i40e: separate
 hw_features from runtime changing flags
In-Reply-To: <6ead4bb4-74f8-56d4-ef77-e925598bb356@oracle.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-5-alice.michael@intel.com>
 <6ead4bb4-74f8-56d4-ef77-e925598bb356@oracle.com>
Message-ID: <02874ECE860811409154E81DA85FBB58829D0682@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Shannon Nelson
> Sent: Friday, June 23, 2017 10:20 AM
> To: intel-wired-lan at osuosl.org
> Subject: Re: [Intel-wired-lan] [next PATCH S74-V2 05/10] i40e: separate
> hw_features from runtime changing flags
> 
> On 6/23/2017 1:24 AM, Alice Michael wrote:
> > From: Jacob Keller <jacob.e.keller@intel.com>
> >
> > The number of flags found in pf->flags has grown quite large, and there
> > are a lot of different types of flags. Most of the flags are simply
> > hardware features which are enabled on some firmware or some MAC types.
> > Other flags are dynamic run-time flags which enable or disable certain
> > features of the driver.
> >
> > Separate these two types of flags into pf->hw_features and pf->flags.
> 
> In general this looks fine and really has long been needed.  My only
> concern is that the name chosen clashes with netdev->hw_features.  This
> is a small nit, but I think a slightly different name would be better in
> the long run.  Even simply "features" would be good.
> 
> sln

I don't mind changing the name if we need, though it will cause a lot of thrash on our end. Personally I don't find it that confusing. Anyone else want to weigh in?

Thanks,
Jake

> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
