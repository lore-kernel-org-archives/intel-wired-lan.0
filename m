From: John Fastabend <john.fastabend@gmail.com>
Date: Sat, 25 Feb 2017 09:38:09 -0800
Subject: [Intel-wired-lan] [net-next PATCH 0/3] XDP for ixgbe
In-Reply-To: <20170225172422.32741.67877.stgit@john-Precision-Tower-5810>
References: <20170225172422.32741.67877.stgit@john-Precision-Tower-5810>
Message-ID: <58B1C101.7020704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-02-25 09:32 AM, John Fastabend wrote:
> This series adds support for XDP on ixgbe. We still need to understand
> adjust head size requirement. If we can compromise at 196B (is this
> correct Alex?) then we can continue to use normal driver RX path and
> avoid having XDP codebase + normal codebase. This is a big win for
> everyone who has to read this code day to day and work on it. I
> suggest if more headroom is needed then it should also be needed in
> the normal stack case and we should provide a generic mechanism to
> build up more headroom. Plus we already have ndo_set_rx_headroom()
> can we just use this?
> 
> If this series can get accepted then we have a series behind it to
> enable batching on TX to push TX Mpps up to line rates. The gist of
> the implementation is to run XDP program in a loop, collecting the
> action results in an array. And then pushing them into the TX routine.
> For a first gen this will likely abort if we get a XDP_PASS routine
> but this is just a matter of code wrangling and lazyness. It can be
> resolved.
> 
> Future looking some improvements are needed, TX routines should take
> an array of packets if we believe long trains of packets will be on
> the RX ring inside a "processing window" (how many descriptors we
> handle per irq clean). Note with many queues on devices we can ensure
> this happens with flow director or even RSS in some cases.
> 
> @Alex, please review. Look at patch 2/3 in paticular and let me know
> what you think about the trade-offs I made there w.r.t. num_xdp_queues
> 
> ---

Hi Jeff,

There might need to be a couple versions to address feedback, but I
assume you can put this on your dev_queue for whenever net-next opens?

Thanks,
John

