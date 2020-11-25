From: Edward Cree <ecree.xilinx@gmail.com>
Date: Wed, 25 Nov 2020 23:02:40 +0000
Subject: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
In-Reply-To: <202011241324.B3439A2@keescook>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
 <202011241324.B3439A2@keescook>
Message-ID: <99a9ffd7-6356-b81d-6e08-7ed74b6fb82c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 24/11/2020 21:25, Kees Cook wrote:
> I still think this isn't right -- it's a case statement that runs off
> the end without an explicit flow control determination.

Proves too much ? for instance
    case foo:
    case bar:
        thing;
        break;
 doesn't require a fallthrough; after case foo:, and afaik
 no-one is suggesting it should.  Yet it, too, is "a case
 statement that runs off the end without an explicit flow
 control determination".

-ed
