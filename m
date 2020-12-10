From: Saeed Mahameed <saeed@kernel.org>
Date: Wed, 09 Dec 2020 22:48:01 -0800
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <cb6b6f50-7cf1-6519-a87a-6b0750c24029@gmail.com>
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
 <1e5e044c8382a68a8a547a1892b48fb21d53dbb9.camel@kernel.org>
 <cb6b6f50-7cf1-6519-a87a-6b0750c24029@gmail.com>
Message-ID: <f4eb614ac91ee7623d13ea77ff3c005f678c512b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2020-12-09 at 20:34 -0700, David Ahern wrote:
> On 12/9/20 10:15 AM, Saeed Mahameed wrote:
> > > My personal experience with this one is mlx5/ConnectX4-LX with a
> > > limit
> > 
> > This limit was removed from mlx5
> > https://patchwork.ozlabs.org/project/netdev/patch/20200107191335.12272-5-saeedm at mellanox.com/
> > Note: you still need to use ehttool to increase from 64 to 128 or
> > 96 in
> > your case.
> > 
> 
> I asked you about that commit back in May:
> 

:/, sorry i missed this email, must have been the mlnx nvidia email
transition.

> https://lore.kernel.org/netdev/198081c2-cb0d-e1d5-901c-446b63c36706 at gmail.com/
> 
> As noted in the thread, it did not work for me.

Still relevant ? I might need to get you some tools to increase #msix
in Firmware.




