From: dan@coverfire.com <dan@coverfire.com>
Date: Sun, 03 Nov 2019 21:08:08 -0500
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <20191031172148.0290b11f@cakuba.netronome.com>
References: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
 <2e27b8d9-4615-cd8d-93de-2adb75d8effa@intel.com>
 <20191031172148.0290b11f@cakuba.netronome.com>
Message-ID: <82fb2eba56d84887772f9d533faa7bda9e3b2ee4.camel@coverfire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-10-31 at 17:21 -0700, Jakub Kicinski wrote:
> 
> My concern was that we want the applications to encode fast path
> logic
> in BPF and load that into the kernel. So your patch works
> fundamentally
> against that goal:

I'm only one AF_XDP user but my main goal is to get packets to
userspace as fast as possible. I don't (currently) need a BPF program
in the path at all. I suspect that many other people that look at
AF_XDP as a DPDK replacement have a similar view.

