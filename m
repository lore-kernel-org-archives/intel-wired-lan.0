From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 10 Sep 2016 10:40:03 -0700
Subject: [Intel-wired-lan] [next PATCH 3/3] ixgbe: Support 4 queue RSS
 on VFs with 1 or 2 queue RSS on PF
In-Reply-To: <E0798E0C-070E-4888-85B6-0C84C3E2B032@purestorage.com>
References: <20160908032606.25312.86849.stgit@localhost.localdomain>
 <20160908032824.25312.34696.stgit@localhost.localdomain>
 <842C844A-0A7A-46FD-A5D7-BF7B584C2A24@purestorage.com>
 <CDB2D0B6-82C2-4E08-BFE0-61D3ECA6502F@purestorage.com>
 <CAKgT0UchckNG=6g_wyrvvJXQvCEYRTUzCCZ2RP5wGcKg0=X5sg@mail.gmail.com>
 <E0798E0C-070E-4888-85B6-0C84C3E2B032@purestorage.com>
Message-ID: <CAKgT0UcyatMoeF5R2nFUGu+aAx-XVQUvHuRWZj5tEcS9jdn4QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The VFRETA can be programmed as you like.  Each VF has its own table so PF
config will not impact the VFs.  All it impacts is the local pool the PF is
using for its own traffic. So if you write it to all zeros that will set it
up for only one queue.  As long as none of the VFs exceed the number of
queues the VF has it shouldn't be a problem.

- Alex

On Friday, September 9, 2016, Ruslan Nikolaev <ruslan@purestorage.com>
wrote:

> Sorry in advance if I have any misconception regarding how VFRETA works.
> But I was more thinking about rss_i being smaller than needed. For
> instance, rss_i is 1 (because RSS=1 for PF) but we use VFs with larger
> number of RX queues (RSS=2 or RSS=4 for VF). Should we program the table
> for VFs using value 2 (or 4) that we at least support 2 RX queues (or 4 RX
> queues if interrupts are shared)? I guess, it does not matter when we use
> just one RX queue.
>
> Thanks,
> Ruslan
>
> On Sep 9, 2016, at 8:32 AM, Alexander Duyck <alexander.duyck@gmail.com
> <javascript:;>> wrote:
>
> > That shouldn't be needed since the VFRETA is actually per virtual pool
> > so it isn't shared with the VFs.  In theory we could support 3 queues
> > on the X550 without any issues, but that would be a change of how
> > things are currently handled so I figured I will leave it as it is for
> > now.
> >
> > - Alex
> >
> > On Thu, Sep 8, 2016 at 6:14 PM, Ruslan Nikolaev <ruslan@purestorage.com
> <javascript:;>> wrote:
> >> I still have on more question. There is also ixgbe_setup_vfreta
> function in
> >> the code. Do we need to adjust rss_i there as well?
> >>
> >> Thanks,
> >> Ruslan
> >>
> >> On Sep 8, 2016, at 11:20 AM, Ruslan Nikolaev <ruslan@purestorage.com
> <javascript:;>> wrote:
> >>
> >> Thank you very much for giving the feedback and creating new set of
> patches!
> >>
> >> Ruslan
> >>
> >> On Sep 7, 2016, at 8:28 PM, Alexander Duyck <alexander.duyck@gmail.com
> <javascript:;>>
> >> wrote:
> >>
> >> From: Alexander Duyck <alexander.h.duyck@intel.com <javascript:;>>
> >>
> >> Instead of limiting the VFs if we don't use 4 queues for RSS in the PF
> we
> >> can instead just limit the RSS queues used to a power of 2.  By doing
> this
> >> we can support use cases where VFs are using more queues than the PF is
> >> currently using and can support RSS if so desired.
> >>
> >> The only limitation on this is that we cannot support 3 queues of RSS in
> >> the PF or VF.  In either of these cases we should fall back to 2 queues
> in
> >> order to be able to use the power of 2 masking provided by the psrtype
> >> register.
> >>
> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com
> <javascript:;>>
> >> ---
> >> drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    7 ++++---
> >> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 +++++++-----
> >> 2 files changed, 11 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> >> b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> >> index bcdc88444ceb..15ab337fd7ad 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> >> @@ -515,15 +515,16 @@ static bool ixgbe_set_sriov_queues(struct
> >> ixgbe_adapter *adapter)
> >> vmdq_i = min_t(u16, IXGBE_MAX_VMDQ_INDICES, vmdq_i);
> >>
> >> /* 64 pool mode with 2 queues per pool */
> >> - if ((vmdq_i > 32) || (rss_i < 4) || (vmdq_i > 16 && pools)) {
> >> + if ((vmdq_i > 32) || (vmdq_i > 16 && pools)) {
> >> vmdq_m = IXGBE_82599_VMDQ_2Q_MASK;
> >> rss_m = IXGBE_RSS_2Q_MASK;
> >> rss_i = min_t(u16, rss_i, 2);
> >> - /* 32 pool mode with 4 queues per pool */
> >> + /* 32 pool mode with up to 4 queues per pool */
> >> } else {
> >> vmdq_m = IXGBE_82599_VMDQ_4Q_MASK;
> >> rss_m = IXGBE_RSS_4Q_MASK;
> >> - rss_i = 4;
> >> + /* We can support 4, 2, or 1 queues */
> >> + rss_i = (rss_i > 3) ? 4 : (rss_i > 1) ? 2 : 1;
> >> }
> >>
> >> #ifdef IXGBE_FCOE
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> index 1c888588cecd..a244d9a67264 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> @@ -3248,7 +3248,8 @@ static void ixgbe_setup_mtqc(struct ixgbe_adapter
> >> *adapter)
> >> mtqc |= IXGBE_MTQC_RT_ENA | IXGBE_MTQC_8TC_8TQ;
> >> else if (tcs > 1)
> >> mtqc |= IXGBE_MTQC_RT_ENA | IXGBE_MTQC_4TC_4TQ;
> >> - else if (adapter->ring_feature[RING_F_RSS].indices == 4)
> >> + else if (adapter->ring_feature[RING_F_VMDQ].mask ==
> >> + IXGBE_82599_VMDQ_4Q_MASK)
> >> mtqc |= IXGBE_MTQC_32VF;
> >> else
> >> mtqc |= IXGBE_MTQC_64VF;
> >> @@ -3475,12 +3476,12 @@ static void ixgbe_setup_reta(struct
> ixgbe_adapter
> >> *adapter)
> >> u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
> >> u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
> >>
> >> - /* Program table for at least 2 queues w/ SR-IOV so that VFs can
> >> + /* Program table for at least 4 queues w/ SR-IOV so that VFs can
> >> * make full use of any rings they may have.  We will use the
> >> * PSRTYPE register to control how many rings we use within the PF.
> >> */
> >> - if ((adapter->flags & IXGBE_FLAG_SRIOV_ENABLED) && (rss_i < 2))
> >> - rss_i = 2;
> >> + if ((adapter->flags & IXGBE_FLAG_SRIOV_ENABLED) && (rss_i < 4))
> >> + rss_i = 4;
> >>
> >> /* Fill out hash function seeds */
> >> for (i = 0; i < 10; i++)
> >> @@ -3544,7 +3545,8 @@ static void ixgbe_setup_mrqc(struct ixgbe_adapter
> >> *adapter)
> >> mrqc = IXGBE_MRQC_VMDQRT8TCEN; /* 8 TCs */
> >> else if (tcs > 1)
> >> mrqc = IXGBE_MRQC_VMDQRT4TCEN; /* 4 TCs */
> >> - else if (adapter->ring_feature[RING_F_RSS].indices == 4)
> >> + else if (adapter->ring_feature[RING_F_VMDQ].mask ==
> >> + IXGBE_82599_VMDQ_4Q_MASK)
> >> mrqc = IXGBE_MRQC_VMDQRSS32EN;
> >> else
> >> mrqc = IXGBE_MRQC_VMDQRSS64EN;
> >>
> >>
> >>
> >>
> >> _______________________________________________
> >> Intel-wired-lan mailing list
> >> Intel-wired-lan at lists.osuosl.org <javascript:;>
> >> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> >>
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org <javascript:;>
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160910/31b857d0/attachment-0001.html>
