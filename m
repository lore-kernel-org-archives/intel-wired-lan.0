From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 22 May 2018 18:47:02 -0700
Subject: [Intel-wired-lan] [PATCH] e1000: check the return of
 pci_get_drvdata() in e1000_remove()
In-Reply-To: <20180523001743.8492-1-chenbo@pdx.edu>
References: <20180523001743.8492-1-chenbo@pdx.edu>
Message-ID: <20180522184702.64cd62f6@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 22 May 2018 17:17:43 -0700
Bo Chen <chenbo@pdx.edu> wrote:

> This check on pci_get_drvdata() prevents potential invalid pointer dereferences,
> and is a common practice in *_remove() functions from other drivers, such as
> 'intel/e100.c', 'amd/pcnet32.c', 'realtek/8139too.c', and 'broadcom/tg3.c'.
> 
> Signed-off-by: Bo Chen <chenbo@pdx.edu>

Why check for something that can never be true.
You are creating dead code paths that can never be exercised.


