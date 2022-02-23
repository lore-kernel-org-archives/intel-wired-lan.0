From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 23 Feb 2022 18:02:22 +0000
Subject: [Intel-wired-lan] [net-next PATCH 23/25] ice: cleanup long
 longs in ice_sriov.c
In-Reply-To: <CO1PR11MB5089CB5838DE2F54C51A079DD63C9@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-24-jacob.e.keller@intel.com>
 <bcba92ad-d159-2abc-f7d1-92043c9c44bc@intel.com>
 <CO1PR11MB5089CB5838DE2F54C51A079DD63C9@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <4228f673158e3f59f3465e617126034d47852e65.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2022-02-23 at 09:42 +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> > Sent: Tuesday, February 22, 2022 5:47 PM
> > To: Keller, Jacob E <jacob.e.keller@intel.com>; Intel Wired LAN
> > <intel-wired-
> > lan at lists.osuosl.org>
> > Subject: Re: [Intel-wired-lan] [net-next PATCH 23/25] ice: cleanup
> > long longs in
> > ice_sriov.c
> > 
> > Subject should be "cleanup long lines" not "cleanup long longs"
> > 
> > 
> > On 2/22/2022 4:27 PM, Jacob Keller wrote:
> > > Before we move the virtchnl message handling from ice_sriov.c
> > > into
> > > ice_virtchnl.c, cleanup some long line warnings to avoid
> > > checkpatch.pl
> > > complaints.
> > > 
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > 
> 
> Oops, thanks for the review Jesse!
> 
> Tony, can you fix this up in your tree?

Yea, I'll fix that up in the tree.

Thanks,
Tony

> Thanks,
> Haje
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

