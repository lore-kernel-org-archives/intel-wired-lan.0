From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 02 Aug 2018 12:55:33 -0700
Subject: [Intel-wired-lan] IXGBE driver questions
In-Reply-To: <CA+WKCcmYi+BeodZy_xdtWrjN05emwJ2Xhm5Lp0Y1tMS1E5kQow@mail.gmail.com>
References: <CA+WKCcmYi+BeodZy_xdtWrjN05emwJ2Xhm5Lp0Y1tMS1E5kQow@mail.gmail.com>
Message-ID: <da133a858c09b8c4192ae04149836f9a326552eb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2018-07-31 at 20:19 +0300, Valery Kobyzev wrote:
> Hello,
> 
> I found your email as commiters to ixgbe drivers.
> 
> I start work very closely with 82599 equipment and nice things like
> as
> Flow Director and SR-IOV.
> 
> And I have several questions without answer.
> 
> 1) flow-director have 8k perfect filters. If I will be have 2k
> filters
> and speed 10 mpps are possible? Any drawbacks?
> 
> 2) I found user-def instruction. But don't see how it work.
> 
> 3) Is it possible to filter ipv4/ether frames with fixed offset in
> frame? Any examples?
> 
> 4) How I can patched (provide additional functions by ethtool) to
> make
> 82599 card as white list? Is it possible to drop all packets that not
> present in flow director filters?

Looks like you have been shopping around to the various contributors to
ixgbe for an answer in private emails.  It appears several others have
provided answers to your questions, but not on a public mailing list.

I have added the intel-wired-lan mailing list, as well as a number of
the other developers you have emailed privately, so that this
discussion can be made public and if others choose to chime in, they
can.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180802/cd77dece/attachment.asc>
