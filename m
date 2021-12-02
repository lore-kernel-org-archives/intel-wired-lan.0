From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 01 Dec 2021 22:50:36 -0800
Subject: [Intel-wired-lan] [PATCH] igc: Avoid possible deadlock during
 suspend/resume
In-Reply-To: <YahqnvgmT63iG48E@kroah.com>
References: <87r1awtdx3.fsf@intel.com>
 <20211201185731.236130-1-vinicius.gomes@intel.com>
 <YahqnvgmT63iG48E@kroah.com>
Message-ID: <87ilw7ts8z.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Dec 01, 2021 at 10:57:31AM -0800, Vinicius Costa Gomes wrote:
>> Inspired by:
>> https://bugzilla.kernel.org/show_bug.cgi?id=215129
>> 
>
> This changelog does not say anything at all, sorry.  Please explain what
> is happening here as the kernel documentation asks you to.

It was intended as just some patch for the reporter to try while
narrowing the problem down. Sorry for the noise.

I should have thought about removing stable from CC.


Thank you,
-- 
Vinicius
