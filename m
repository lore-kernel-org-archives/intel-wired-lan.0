From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Thu, 15 Aug 2019 12:28:44 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/5] Add support for SKIP_BPF
 flag for AF_XDP sockets
In-Reply-To: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
References: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <20190815122844.52eeda08@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 14 Aug 2019 20:46:18 -0700, Sridhar Samudrala wrote:
> This patch series introduces XDP_SKIP_BPF flag that can be specified
> during the bind() call of an AF_XDP socket to skip calling the BPF 
> program in the receive path and pass the buffer directly to the socket.
> 
> When a single AF_XDP socket is associated with a queue and a HW
> filter is used to redirect the packets and the app is interested in
> receiving all the packets on that queue, we don't need an additional 
> BPF program to do further filtering or lookup/redirect to a socket.
> 
> Here are some performance numbers collected on 
>   - 2 socket 28 core Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
>   - Intel 40Gb Ethernet NIC (i40e)
> 
> All tests use 2 cores and the results are in Mpps.
> 
> turbo on (default)
> ---------------------------------------------	
>                       no-skip-bpf    skip-bpf
> ---------------------------------------------	
> rxdrop zerocopy           21.9         38.5 
> l2fwd  zerocopy           17.0         20.5
> rxdrop copy               11.1         13.3
> l2fwd  copy                1.9          2.0
> 
> no turbo :  echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
> ---------------------------------------------	
>                       no-skip-bpf    skip-bpf
> ---------------------------------------------	
> rxdrop zerocopy           15.4         29.0
> l2fwd  zerocopy           11.8         18.2
> rxdrop copy                8.2         10.5
> l2fwd  copy                1.7          1.7
> ---------------------------------------------	

Could you include a third column here - namely the in-XDP performance?
AFAIU the way to achieve better performance with AF_XDP is to move the
fast path into the kernel's XDP program..

Maciej's work on batching XDP program's execution should lower the
retpoline overhead, without leaning close to the bypass model.
