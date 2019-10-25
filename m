From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 25 Oct 2019 09:42:48 +0200
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <68d6e154-8646-7904-f081-10ec32115496@intel.com>
References: <CAADnVQKwnMChzeGaC66A99cHn5szB4hPZaGXq8JAhd8sjrdGeA@mail.gmail.com>
 <68d6e154-8646-7904-f081-10ec32115496@intel.com>
Message-ID: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 24 Oct 2019 at 20:12, Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
[...]
>
> With mitigations ON
> -------------------
> Samples: 6K of event 'cycles', 4000 Hz, Event count (approx.): 5646512726
> bpf_prog_3c8251c7e0fef8db  bpf_prog_3c8251c7e0fef8db [Percent: local period]
>   45.05      push   %rbp
>    0.02      mov    %rsp,%rbp
>    0.03      sub    $0x8,%rsp
>   22.09      push   %rbx

[...]

>
> Do you see any issues with this data? With mitigations ON push %rbp and push %rbx overhead seems to
> be pretty high.

That's sample skid from the retpoline thunk when entring the XDP
program. Pretty expensive push otherwise! :-)

Another thought; Disclaimer: I'm no spectrev2 expert, and probably not
getting the mitigations well enough. So this is me trying to swim at
the deep end! Would it be possible to avoid the retpoline when
entering the XDP program. At least for some XDP program that can be
proved "safe"? If so, PeterZ's upcoming static_call could be used from
the driver side.


Bj?rn
