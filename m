From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 18 Oct 2019 21:22:52 +0200
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <acf69635-5868-f876-f7da-08954d1f690e@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
 <CAADnVQ+XxmvY0cs8MYriMMd7=2TSEm4zCtB+fs2vkwdUY6UgAQ@mail.gmail.com>
 <3ED8E928C4210A4289A677D2FEB48235140134CE@fmsmsx111.amr.corp.intel.com>
 <2bc26acd-170d-634e-c066-71557b2b3e4f@intel.com>
 <CAADnVQ+qq6RLMjh5bB1ugXP5p7vYM2F1fLGFQ2pL=2vhCLiBdA@mail.gmail.com>
 <2032d58c-916f-d26a-db14-bd5ba6ad92b9@intel.com>
 <CAADnVQ+CH1YM52+LfybLS+NK16414Exrvk1QpYOF=HaT4KRaxg@mail.gmail.com>
 <acf69635-5868-f876-f7da-08954d1f690e@intel.com>
Message-ID: <87wod1dfjn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

"Samudrala, Sridhar" <sridhar.samudrala@intel.com> writes:

> Performance Results
> ===================
> Only 1 core is used in all these testcases as the app and the queue irq are pinned to the same core.
>
> ----------------------------------------------------------------------------------
>                                 mitigations ON                mitigations OFF
>    Testcase              ----------------------------------------------------------
>                          no patches    with patches       no patches   with patches
> ----------------------------------------------------------------------------------
> AF_XDP default rxdrop        X             X                   Y            Y

Is this really exactly the same with and without patches? You're adding
an extra check to xdp_do_redirect(); are you really saying that the
impact of that is zero?

> AF_XDP direct rxdrop        N/A          X+46%                N/A         Y+25%
> Kernel rxdrop              X+61%         X+61%               Y+53%        Y+53%
> ----------------------------------------------------------------------------------
>
> Here Y is pps with CPU security mitigations turned OFF and it is 26%
> better than X.

Any particular reason you're not sharing the values of X and Y?

-Toke

