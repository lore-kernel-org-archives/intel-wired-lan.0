From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Thu, 31 Oct 2019 17:21:48 -0700
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <2e27b8d9-4615-cd8d-93de-2adb75d8effa@intel.com>
References: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
 <2e27b8d9-4615-cd8d-93de-2adb75d8effa@intel.com>
Message-ID: <20191031172148.0290b11f@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 31 Oct 2019 15:38:42 -0700, Samudrala, Sridhar wrote:
> Do you think it will be possible to avoid this overhead when mitigations are turned ON?
> The other part of the overhead is going through the redirect path.

Yes, you should help Maciej with the XDP bulking.

> Can i assume that your silence as an indication that you are now okay with optional bypass
> flag as long as it doesn't effect the normal XDP datapath. If so, i will respin and submit
> the patches against the latest bpf-next

This logic baffles me. I absolutely hate when people repost patches
after I nack them without even as much as mentioning my objections in
the cover letter.

My concern was that we want the applications to encode fast path logic
in BPF and load that into the kernel. So your patch works fundamentally
against that goal:

I worry that with the volume of patches that get posted each day
objections of a measly contributor like myself will get forgotten 
if I don't reply to each posting, yet replying each time makes me look
bullish or whatnot (apart from being an utter waste of time).

Ugh.
