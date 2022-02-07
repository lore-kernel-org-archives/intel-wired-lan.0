From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 7 Feb 2022 19:48:14 +0000
Subject: [Intel-wired-lan] [PATCH] ice: fix concurrent reset and removal
 of VFs
In-Reply-To: <bb1dc3f7-492b-0410-1fe7-ee66e4a8a506@intel.com>
References: <20220207182329.2078272-1-jacob.e.keller@intel.com>
 <bb1dc3f7-492b-0410-1fe7-ee66e4a8a506@intel.com>
Message-ID: <CO1PR11MB5089041B8D2D69D262AFF2F0D62C9@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Sent: Monday, February 07, 2022 10:40 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Intel Wired LAN <intel-wired-
> lan at lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH] ice: fix concurrent reset and removal of VFs
> 
> On 2/7/2022 10:23 AM, Jacob Keller wrote:
> > Commit c503e63200c6 ("ice: Stop processing VF messages during teardown")
> > introduced a driver state flag, ICE_VF_DEINIT_IN_PROGRESS, which is
> > intended to prevent some issues with concurrently handling messages from
> > VFs while tearing down the VFs.
> >
> > This change was motivated by crashes caused while tearing down and
> > bringing up VFs in rapid succession.
> >
> > It turns out that the fix actually introduces issues with the VF driver
> > caused because the PF no longer responds to any messages sent by the VF
> > during its .remove routine. This results in the VF potentially removing
> > its DMA memory before the PF has shut down the device queues.
> >
> > Additionally, the fix doesn't actually resolve concurrency issues within
> > the ice driver. It is possible for a VF to initiate a reset just prior
> > to the ice driver removing VFs. This can result in the remove task
> > concurrently operating while the VF is being reset. This results in
> > similar memory corruption and panics purportedly fixed by that commit.
> >
> > Fix this concurrency at its root by protecting both the reset and
> > removal flows using the existing VF cfg_lock. This ensures that we
> > cannot remove the VF while any outstanding critical tasks such as a
> > virtchnl message or a reset are occurring.
> >
> > This locking change also fixes the root cause originally fixed by commit
> > c503e63200c6 ("ice: Stop processing VF messages during teardown"), so we
> > can simply revert it.
> >
> > Note that I kept these two changes together because simply reverting the
> > original commit alone would leave the driver vulnerable to worse race
> > conditions.
> >
> > Fixes: c503e63200c6 ("ice: Stop processing VF messages during teardown")
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Tree target (net or net-next) wasn't specified in title, since this is a
> fix maybe it should be targeted to net?
> 

Oh. Oops. Yes this should have been [net PATCH]

Thanks,
Jake
