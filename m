From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 3 Nov 2015 23:08:45 +0000
Subject: [Intel-wired-lan] [next-queue] fm10k: explain why we need
 __packed on some TLV structures
In-Reply-To: <563937DE.6000303@gmail.com>
References: <1446579154-1112-1-git-send-email-jacob.e.keller@intel.com>
 <56392B8B.4090208@gmail.com> <1446587745.3990.25.camel@intel.com>
 <563937DE.6000303@gmail.com>
Message-ID: <1446592125.3990.31.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-11-03 at 14:40 -0800, Alexander Duyck wrote:
> On 11/03/2015 01:55 PM, Keller, Jacob E wrote:
> > On Tue, 2015-11-03 at 13:47 -0800, Alexander Duyck wrote:
> > > On 11/03/2015 11:32 AM, Jacob Keller wrote:
> > > > Add an explanatory comment about the __packed attribute on
> > > > these
> > > > structures due to TLV data layout requirements.
> > > > 
> > > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > > ---
> > > >    drivers/net/ethernet/intel/fm10k/fm10k_pf.h | 5 +++++
> > > >    1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
> > > > b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
> > > > index a8fc512a2416..661a4062b756 100644
> > > > --- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
> > > > +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
> > > > @@ -74,6 +74,11 @@ enum fm10k_pf_tlv_attr_id_v1 {
> > > >    #define FM10K_MSG_UPDATE_PVID_PVID_SHIFT	16
> > > >    #define FM10K_MSG_UPDATE_PVID_PVID_SIZE		16
> > > >    
> > > > +/* The following data structures are overlayed specifically to
> > > > TLV
> > > > mailbox
> > > > + * messages, and must not have gaps between their values. They
> > > > must line up
> > > > + * correctly to the TLV definition.
> > > > + */
> > > > +
> > > >    struct fm10k_mac_update {
> > > >    	__le32	mac_lower;
> > > >    	__le16	mac_upper;
> > > Really I don't think this tells the story of why the packed
> > > attribute
> > > is
> > > needed.  From what I can tell there aren't any holes in the
> > > structures
> > > themselves.  It looks like the issue is the padding on the end. 
> > >  From
> > > what I can tell only the only message that really needs the
> > > packed
> > > attribute it is the 1588 message because it uses __le64 values
> > > and as
> > > such the actual size will vary by 4 bytes between 64b and 32b
> > > systems.
> > > 
> > I know at least one of the structures broke the mailbox due to
> > sizing,
> > because there were gaps in how the structure was laid out in
> > memory,
> > when being copied into the TLV. It doesn't just add space at the
> > end,
> > we had a huge bug when this was originally added due to sizing
> > issues.
> > I think this comment explains the reasoning even if it doesn't
> > necessarily required for these particular structures, we're better
> > off
> > being safe by specifying __packed for these structures given their
> > usage.
> 
> Actually my concern is that __packed can make things less safe. 
> Specifically the TLV code as it currently is assumes structures are 
> aligned by at least 32 bits.  Using the __packed attribute
> potentially 
> throws that out the window and only 8b aligns the structure.  For now
> things are safe because all of the structures are 32b aligned at
> least.
> 
> What you are probably looking for is something more like 
> "__attribute__((packed, aligned(4))" instead of just straight packed.
>   
> That way if any new fields are added you would get the proper
> alignment 
> in terms of size since the TLV code assumes a minimum of 32b
> alignment 
> for structures.
> 
> - Alex
> 

Hmm. It does appear to be doing chunks of the structure in 4byte
alignment, so that's correct. I thought it was different but a quick
glance at the TLV code suggests you are correct.

I'll work up that change.

Regards,
Jake
