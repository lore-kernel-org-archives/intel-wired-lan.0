From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Thu, 17 Dec 2015 18:52:15 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Enable RSS for i211 adapter
In-Reply-To: <CAMt9YRrURroSO3TXQ+-y0kvg0k=TvwO-P1VKTD-15U5hJbr_3Q@mail.gmail.com>
References: <20151216193058.5383.11943.stgit@localhost.localdomain>
 <9B4A1B1917080E46B64F07F2989DADD65AAE7871@ORSMSX114.amr.corp.intel.com>
 <CAMt9YRrURroSO3TXQ+-y0kvg0k=TvwO-P1VKTD-15U5hJbr_3Q@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65AAE7897@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As I was composing this email, I noticed the same thing. I'll double-check to make sure the comment is actually necessary.

Thanks Alex!

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565


-----Original Message-----
From: Alex Duyck [mailto:aduyck at mirantis.com] 
Sent: Thursday, December 17, 2015 10:43 AM
To: Fujinaka, Todd
Cc: intel-wired-lan at lists.osuosl.org; alexander.duyck at gmail.com; Tal Abudi
Subject: Re: [Intel-wired-lan] [PATCH] igb: Enable RSS for i211 adapter

On Thu, Dec 17, 2015 at 10:37 AM, Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
> I've spent too much time looking into this. I think this was added when someone looked for the register value and it was the same as E1000_MRQC_ENABLE_RSS_8Q and disabled i211 because it doesn't have 8 queues.
>
> I've been asked if you could spin this to add a comment that the two values are the same (E1000_MRQC_ENABLE_RSS_8Q and E1000_MRQC_ENABLE_RSS_4Q).

That would be even more confusing since the value that is being used is RSS_4Q so I am not sure where the 8Q comes into play.  I guess at some point it was renamed?  Feel free to modify the code however you want.  I was just going through and trying to figure out the issue that had been reported and I noticed it wasn't getting enabled.  It's fine with me if you drop me as author if you guys rewrite the patch and add a comment.  You could probably just add a Suggested-by credit to the patch you generate.

- Alex
