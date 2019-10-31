From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Thu, 31 Oct 2019 15:38:42 -0700
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
References: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
Message-ID: <2e27b8d9-4615-cd8d-93de-2adb75d8effa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


[...]
> >
> > With mitigations ON
> > -------------------
> > Samples: 6K of event 'cycles', 4000 Hz, Event count (approx.): 5646512726
> > bpf_prog_3c8251c7e0fef8db  bpf_prog_3c8251c7e0fef8db [Percent: local period]
> >   45.05      push   %rbp
> >    0.02      mov    %rsp,%rbp
> >    0.03      sub    $0x8,%rsp
> >   22.09      push   %rbx

> [...]
> >
> > Do you see any issues with this data? With mitigations ON push %rbp and push %rbx overhead seems to
> > be pretty high.

> That's sample skid from the retpoline thunk when entring the XDP
> program. Pretty expensive push otherwise! :-)

> Another thought; Disclaimer: I'm no spectrev2 expert, and probably not
> getting the mitigations well enough. So this is me trying to swim at
> the deep end! Would it be possible to avoid the retpoline when
> entering the XDP program. At least for some XDP program that can be
> proved "safe"? If so, PeterZ's upcoming static_call could be used from
> the driver side.

Alexei, Jakub

Do you think it will be possible to avoid this overhead when mitigations are turned ON?
The other part of the overhead is going through the redirect path.

Can i assume that your silence as an indication that you are now okay with optional bypass
flag as long as it doesn't effect the normal XDP datapath. If so, i will respin and submit
the patches against the latest bpf-next

-Sridhar
