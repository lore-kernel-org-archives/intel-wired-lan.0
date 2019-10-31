From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Oct 2019 16:15:34 -0700
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <2e27b8d9-4615-cd8d-93de-2adb75d8effa@intel.com>
References: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
 <2e27b8d9-4615-cd8d-93de-2adb75d8effa@intel.com>
Message-ID: <CAADnVQLJ95j5jfh5jFApjs4bYzOxuPcrMgH9jbdGGvOWQEPRyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 31, 2019 at 3:38 PM Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
> Alexei, Jakub
>
> Do you think it will be possible to avoid this overhead when mitigations are turned ON?

yes

> The other part of the overhead is going through the redirect path.
>
> Can i assume that your silence as an indication that you are now okay with optional bypass
> flag as long as it doesn't effect the normal XDP datapath. If so, i will respin and submit
> the patches against the latest bpf-next

I'm still against it.
Looks like the only motivation for it is extra overhead due to retpolines.
imo it's not a good reason to introduce a bunch of extra code helping
single kernel feature.
We will have proper solution for indirect calls.
