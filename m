From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 30 Oct 2019 10:43:49 +0100
Subject: [Intel-wired-lan] [PATCH v1] igc: Add scatter gather support
In-Reply-To: <20191030090848.20842-1-sasha.neftin@intel.com>
References: <20191030090848.20842-1-sasha.neftin@intel.com>
Message-ID: <090fd6fa-bccd-ff67-8326-6eed7a9d5d56@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


On 30.10.19 10:08, Sasha Neftin wrote:
> Scatter gather is used to do DMA data transfers of data that is written to
> noncontiguous areas of memory.
> This patch enable scatter gather support.

enable*s*

Do you have numbers, if and how this improves performance?

How can this be tested?

[?]


Kind regards,

Paul
