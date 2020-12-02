From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 2 Dec 2020 14:11:00 -0600
Subject: [Intel-wired-lan] [PATCH v2 2/5] e1000e: Move all s0ix related
 code into it's own source file
In-Reply-To: <20201202161748.128938-3-mario.limonciello@dell.com>
Message-ID: <20201202201100.GA1466664@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

s/it's/its/ (in subject as well as below).

Previous patches used "S0ix", not "s0ix" (in subject as well as
below, as well as subject and commit log of 3/5 and 5/5).

On Wed, Dec 02, 2020 at 10:17:45AM -0600, Mario Limonciello wrote:
> Introduce a flag to indicate the device should be using the s0ix
> flows and use this flag to run those functions.

Would be nicer to have a move that does nothing else + a separate
patch that adds a flag so it's more obvious, but again, not my circus.

> Splitting the code to it's own file will make future heuristics
> more self containted.

s/containted/contained/

Bjorn
