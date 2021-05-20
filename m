From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Thu, 20 May 2021 08:20:00 +0200
Subject: [Intel-wired-lan] [PATCH net v4] igb: Fix XDP with PTP enabled
In-Reply-To: <e4568dc225edd00122b35be37cef9fac68329508.camel@intel.com>
References: <20210503072800.79936-1-kurt@linutronix.de>
 <20210504102827.342f6302@carbon> <20210519153418.00c4cc42@carbon>
 <e4568dc225edd00122b35be37cef9fac68329508.camel@intel.com>
Message-ID: <87cztmgc4v.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed May 19 2021, Nguyen, Anthony L wrote:
> On Wed, 2021-05-19 at 15:34 +0200, Jesper Dangaard Brouer wrote:
>> Hi Maintainers,
>> 
>> What is the status on this patch?
>
> I'm awaiting testing from our validation. They expect to finish by the
> end of the week; I'll send out the patch as soon as they've completed.
>

Thanks! I've got also a backport of this patch for v5.10.x, so that
people can use the latest LTS e.g., with PREEMPT_RT and working PTP and
XDP. Let me know if there's interest in it.

Thanks,
Kurt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 861 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210520/875206a0/attachment.asc>
