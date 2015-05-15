From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Fri, 15 May 2015 21:38:05 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add array of MAC type
 dependent values
In-Reply-To: <55558766.4070102@gmail.com>
References: <20150514221630.16569.73269.stgit@dcs-desk.jf.intel.com>
 <55553F13.2010605@redhat.com>
 <A9182E1B-C952-444F-9F31-073EC66CDC7A@intel.com> <55558766.4070102@gmail.com>
Message-ID: <9A7C5657-C218-4563-8CE7-4FD03D8A1D99@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 14, 2015, at 10:43 PM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> On 05/14/2015 05:54 PM, Rustad, Mark D wrote:
>>> On May 14, 2015, at 5:34 PM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
>>> 
>>> On 05/14/2015 03:16 PM, Don Skidmore wrote:
>> <snip>
>> Yes, 8259X would be better than "base". I am terrible at naming...
> 
> I know how it feels.  I had Linus reject an entire patch series I did a few months back just because he didn't like the name of the barrier primitives I created.

Yeah, I saw that. It is especially important to get such globally-visible names right.

> I don't think it would preclude it, it would just require renaming the define in those optimized paths.  If anything it makes it more explicit which should be more readable.

Yes. It makes these defines even more explicit. It also ensures that every reference to a new varying symbol gets looked at and explicitly changed, since the preprocessor will error on completely omitted parameters. This realization made me decide that your suggestions are exactly right. Forcing a decision on every reference is a good thing.

> For example I hadn't noticed until now that the change above could use the same GPIEN value for both since only an 82598 part has the FAN_FAIL_CAPABLE bit set so it doesn't make sense to include bits for x540 and the like since only one MAC supports a fan failure check.

You know, I'm not sure if that is true any more. I used to think that was the case, but now I'm not sure.

>> Well, since the current implementation has the symbol with no model suffix as the "base" value, the underscore could not be included so that those values would be generated into the "base" array - note the null parameter passed to the IXGBE_MVALS_INIT macro. Of course if we rename everything as you suggest, we could supply the underscore in the macro.
> 
> Yeah, I kind of noticed that.  Still I think it is cleaner to just add a suffix to everything and replace the base name by making it the macro that takes the argument.

Yes. Don and I ended up agreeing on that when we talked about it this morning.

> The other thing you guys may want to do is go through and audit the function calls.  For example are you guys seeing SFP cages used with the x540 or x550?  If not ixgbe_check_sfp_event is a spot you could probably strip down to just using the 8259X defines since last I knew SFP cages were for 8259X NICs only.

We do have other SFP cases to consider.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150515/6903b08a/attachment.asc>
