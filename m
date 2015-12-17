From: Alex Duyck <aduyck@mirantis.com>
Date: Thu, 17 Dec 2015 10:42:39 -0800
Subject: [Intel-wired-lan] [PATCH] igb: Enable RSS for i211 adapter
In-Reply-To: <9B4A1B1917080E46B64F07F2989DADD65AAE7871@ORSMSX114.amr.corp.intel.com>
References: <20151216193058.5383.11943.stgit@localhost.localdomain>
 <9B4A1B1917080E46B64F07F2989DADD65AAE7871@ORSMSX114.amr.corp.intel.com>
Message-ID: <CAMt9YRrURroSO3TXQ+-y0kvg0k=TvwO-P1VKTD-15U5hJbr_3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Dec 17, 2015 at 10:37 AM, Fujinaka, Todd
<todd.fujinaka@intel.com> wrote:
> I've spent too much time looking into this. I think this was added when someone looked for the register value and it was the same as E1000_MRQC_ENABLE_RSS_8Q and disabled i211 because it doesn't have 8 queues.
>
> I've been asked if you could spin this to add a comment that the two values are the same (E1000_MRQC_ENABLE_RSS_8Q and E1000_MRQC_ENABLE_RSS_4Q).

That would be even more confusing since the value that is being used
is RSS_4Q so I am not sure where the 8Q comes into play.  I guess at
some point it was renamed?  Feel free to modify the code however you
want.  I was just going through and trying to figure out the issue
that had been reported and I noticed it wasn't getting enabled.  It's
fine with me if you drop me as author if you guys rewrite the patch
and add a comment.  You could probably just add a Suggested-by credit
to the patch you generate.

- Alex
