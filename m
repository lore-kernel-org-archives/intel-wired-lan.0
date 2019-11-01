From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Fri, 1 Nov 2019 11:31:11 -0700
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <20191031172148.0290b11f@cakuba.netronome.com>
References: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
 <2e27b8d9-4615-cd8d-93de-2adb75d8effa@intel.com>
 <20191031172148.0290b11f@cakuba.netronome.com>
Message-ID: <8481fe0a-fa7b-c689-1e51-1a3253176509@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/31/2019 5:21 PM, Jakub Kicinski wrote:
> On Thu, 31 Oct 2019 15:38:42 -0700, Samudrala, Sridhar wrote:
>> Do you think it will be possible to avoid this overhead when mitigations are turned ON?
>> The other part of the overhead is going through the redirect path.
> 
> Yes, you should help Maciej with the XDP bulking.
> 
>> Can i assume that your silence as an indication that you are now okay with optional bypass
>> flag as long as it doesn't effect the normal XDP datapath. If so, i will respin and submit
>> the patches against the latest bpf-next
> 
> This logic baffles me. I absolutely hate when people repost patches
> after I nack them without even as much as mentioning my objections in
> the cover letter.

Sorry if you got the impression that i didn't take your feedback. I CCed you
and also included the kernel rxdrop data that you requested in the original
series.

> 
> My concern was that we want the applications to encode fast path logic
> in BPF and load that into the kernel. So your patch works fundamentally
> against that goal:

So looks like you are saying that the fundamental requirement is that all AF_XDP
packets need to go via a BPF program.

The reason i proposed direct receive is because of the overhead we are seeing
with going via BPF program for apps that want to receive all the packets on a
specific queue.

I agree that there is work going on to reduce this overhead with bulking and avoiding
the retpoline.
We can revisit after these optimizations get in and then see if it is still useful
to provide a direct receive option.

-Sridhar
