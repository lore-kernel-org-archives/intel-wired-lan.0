From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 08 Feb 2018 09:57:43 -0800
Subject: [Intel-wired-lan] [net-next] Documentation: Update Intel wired
 LAN docs
In-Reply-To: <c1c68750-fc0d-8e75-4535-78fb4c8048b9@oracle.com>
References: <20180206210029.27875-1-jeffrey.t.kirsher@intel.com>
 <c1c68750-fc0d-8e75-4535-78fb4c8048b9@oracle.com>
Message-ID: <1518112663.26676.5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-02-07 at 16:37 -0800, Shannon Nelson wrote:
> On 2/6/2018 1:00 PM, Jeff Kirsher wrote:
> > Updated the kernel documentation on e1000e, fm10k, i40e/vf, igb/vf
> > and
> > ixgbe/vf.
> > 
> > Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> I didn't really read this for details, but I saw a few things that 
> jumped out at me and noted them below.  In general, it would be nice
> to 
> have someone go through them and do proper updates to make these
> files 
> look consistent so they look like they came from the same company. 
> I 
> know there are differences in the individual drivers, but there are
> a 
> lot of similarities and these files should not all look so
> different. 
> There's also still a lot of out-dated information here that doesn't
> do 
> your customer any good.
> 
> Also, with so many things changed in each file, it would be much
> easier 
> to review if each was a separate patch rather than having to page 
> through a few thousand lines in a single email.  You'd be much more 
> likely to have someone who knows about a particular driver review at 
> least that one file.

True, we do need to go through the copyright headers for all the
drivers and make sure they are consistent.  Not sure if I want to "add"
those kind of changes to this patch, but I will take it under
consideration.

As far as the "one" patch versus many patches, as it stand with just
the SPDX change, I am sure David Miller would rather have one patch to
make this change versus 8 patches.  This is based on my experiences in
the past when dealing with changes like this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180208/55f9f1f3/attachment.asc>
