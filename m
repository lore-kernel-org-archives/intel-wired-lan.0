From: Michael, Alice <alice.michael@intel.com>
Date: Wed, 30 Mar 2022 16:47:18 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Fix logic of getting XSK
 pool associated with Tx queue
In-Reply-To: <20220329195522.63d332fb@ceranb>
References: <20220329102752.1481125-1-ivecera@redhat.com>
 <YkL0wfgyCq5s8vdu@boxer> <20220329195522.63d332fb@ceranb>
Message-ID: <MWHPR11MB0062B06CAE27C58EEE54F162E41F9@MWHPR11MB0062.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ivan Vecera <ivecera@redhat.com>
> Sent: Tuesday, March 29, 2022 10:55 AM
> To: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Cc: netdev at vger.kernel.org; poros <poros@redhat.com>; mschmidt
> <mschmidt@redhat.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
> <daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John
> Fastabend <john.fastabend@gmail.com>; Andrii Nakryiko
> <andrii@kernel.org>; Martin KaFai Lau <kafai@fb.com>; Song Liu
> <songliubraving@fb.com>; Yonghong Song <yhs@fb.com>; KP Singh
> <kpsingh@kernel.org>; Jeff Kirsher <jeffrey.t.kirsher@intel.com>; Krzysztof
> Kazimierczak <krzysztof.kazimierczak@intel.com>; Lobakin, Alexandr
> <alexandr.lobakin@intel.com>; moderated list:INTEL ETHERNET DRIVERS
> <intel-wired-lan@lists.osuosl.org>; open list <linux-kernel@vger.kernel.org>;
> open list:XDP (eXpress Data Path) <bpf@vger.kernel.org>
> Subject: Re: [PATCH net] ice: Fix logic of getting XSK pool associated with Tx
> queue
> 
> On Tue, 29 Mar 2022 14:00:01 +0200
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> 
> > Thanks for this fix! I did exactly the same patch yesterday and it's
> > already applied to bpf tree:
> >
> > https://lore.kernel.org/bpf/20220328142123.170157-5-maciej.fijalkowski
> > @intel.com/T/#u
> >
> > Maciej
> 
> Thanks for info... Nice human race condition ;-)
> 
> I.

I'm covering for Tony this week maintaining this tree.  He let me know there were a few patches you had to send Ivan and I was waiting on this one.  If I'm following correctly, this one will be dropped and the other ones are ready to be sent now to net then?

Alice.
