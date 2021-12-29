From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 28 Dec 2021 17:33:39 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next v2] net: don't include
 filter.h from net/sock.h
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
References: <20211229004913.513372-1-kuba@kernel.org>
Message-ID: <5a82690c-7dc0-81de-4dd6-06e26e4b9b92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 12/28/2021 4:49 PM, Jakub Kicinski wrote:
> sock.h is pretty heavily used (5k objects rebuilt on x86 after
> it's touched). We can drop the include of filter.h from it and
> add a forward declaration of struct sk_filter instead.
> This decreases the number of rebuilt objects when bpf.h
> is touched from ~5k to ~1k.
> 
> There's a lot of missing includes this was masking. Primarily
> in networking tho, this time.
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

It would be nice if we used the number of files rebuilt because of a 
header file change as another metric that the kernel is evaluated with 
from release to release (or even on a commit by commit basis). Food for 
thought.
-- 
Florian
