From: Saeed Mahameed <saeed@kernel.org>
Date: Wed, 09 Dec 2020 09:15:41 -0800
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <e1573338-17c0-48f4-b4cd-28eeb7ce699a@gmail.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com> <878sad933c.fsf@toke.dk>
 <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <20201207230755.GB27205@ranger.igk.intel.com>
 <5fd068c75b92d_50ce20814@john-XPS-13-9370.notmuch>
 <20201209095454.GA36812@ranger.igk.intel.com>
 <20201209125223.49096d50@carbon>
 <e1573338-17c0-48f4-b4cd-28eeb7ce699a@gmail.com>
Message-ID: <1e5e044c8382a68a8a547a1892b48fb21d53dbb9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2020-12-09 at 08:41 -0700, David Ahern wrote:
> On 12/9/20 4:52 AM, Jesper Dangaard Brouer wrote:
> > > > still load and either share queues across multiple cores or
> > > > restirct
> > > > down to a subset of CPUs.  
> > > 
> > > And that's the missing piece of logic, I suppose.
> > > 
> > > > Do you need 192 cores for a 10gbps nic, probably not.  
> > > 
> > > Let's hear from Jesper :p
> > 
> > LOL - of-cause you don't need 192 cores.  With XDP I will claim
> > that
> > you only need 2 cores (with high GHz) to forward 10gbps wirespeed
> > small
> > packets.
> 
> You don't need 192 for 10G on Rx. However, if you are using
> XDP_REDIRECT
> from VM tap devices the next device (presumably the host NIC) does
> need
> to be able to handle the redirect.
> 
> My personal experience with this one is mlx5/ConnectX4-LX with a
> limit

This limit was removed from mlx5
https://patchwork.ozlabs.org/project/netdev/patch/20200107191335.12272-5-saeedm at mellanox.com/
Note: you still need to use ehttool to increase from 64 to 128 or 96 in
your case.

> of 63 queues and a server with 96 logical cpus. If the vhost thread
> for
> the tap device runs on a cpu that does not have an XDP TX Queue, the
> packet is dropped. This is a really bizarre case to debug as some
> packets go out fine while others are dropped.

I agree, the user experience horrible.

