From: Venkataramanan, Anirudh <anirudh.venkataramanan@intel.com>
Date: Thu, 15 Mar 2018 18:27:50 +0000
Subject: [Intel-wired-lan] [PATCH 03/15] ice: Start hardware
 initialization
In-Reply-To: <f07d8b58-aea8-c7a9-fc93-ac6d220ade37@oracle.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-4-anirudh.venkataramanan@intel.com>
 <657f1de9-9727-6b01-1f79-957db6ef8852@oracle.com>
 <1521065151.696.91.camel@intel.com>
 <f07d8b58-aea8-c7a9-fc93-ac6d220ade37@oracle.com>
Message-ID: <1521138469.15392.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-03-15 at 10:00 -0700, Shannon Nelson wrote:
> On 3/14/2018 3:05 PM, Venkataramanan, Anirudh wrote:
> > On Mon, 2018-03-12 at 19:05 -0700, Shannon Nelson wrote:
> > > On 3/9/2018 9:21 AM, Anirudh Venkataramanan wrote:
> 
> 
> > > > +
> > > > +/**
> > > > + * ice_read_sr_aq - Read Shadow RAM.
> > > > + * @hw: pointer to the HW structure
> > > > + * @offset: offset in words from module start
> > > > + * @words: number of words to read
> > > > + * @data: buffer for words reads from Shadow RAM
> > > > + * @last_command: tells the AdminQ that this is the last
> > > > command
> > > > + *
> > > > + * Reads 16-bit word buffers from the Shadow RAM using the
> > > > admin
> > > > command.
> > > > + */
> > > > +static enum ice_status
> > > > +ice_read_sr_aq(struct ice_hw *hw, u32 offset, u16 words, u16
> > > > *data,
> > > > +	       bool last_command)
> > > > +{
> > > > +	enum ice_status status;
> > > > +
> > > > +	status = ice_check_sr_access_params(hw, offset,
> > > > words);
> > > > +	if (!status)
> > > > +		status = ice_aq_read_nvm(hw, 0, 2 * offset, 2
> > > > *
> > > > words, data,
> > > 
> > > Why the doubling of offset and words?  If this is some general
> > > adjustment made for the AQ interface, it should be made in
> > > ice_aq_read_nvm().  If not, then some explanation is needed here.
> > 
> > ice_read_sr_aq expects a word offset and size in words. The
> > ice_aq_read_nvm interface expects offset and size in bytes. The
> > doubling is a conversion from word offset/size to byte offset/size.
> 
> In that case, this might be a good place for a small comment for
> readers 
> like me who don't have the spec available.

Sure thing! :-)

> 
> sln
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3302 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180315/7f02ce32/attachment.bin>
