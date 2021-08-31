From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 31 Aug 2021 22:56:57 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix limit of total
 number of queues to active queues of VF
In-Reply-To: <20210830090220.271120-1-karen.sornek@intel.com>
References: <20210830090220.271120-1-karen.sornek@intel.com>
Message-ID: <5a1a2e60f5e22ea807a142d057a28face0c82a1f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-08-30 at 11:02 +0200, Karen Sornek wrote:
> In the absence of this validation, if the user requests to
> configure queues more than the enabled queues, it results in
> sending the requested number of queues to the kernel stack
> (due to the asynchronous nature of VF response), in which
> case the stack might pick a queue to transmit that is not
> enabled and result in Tx hang. Fix this bug by
> limiting the total number of queues allocated for VF to
> active queues of VF.
> 
> Fixes: 129cf89e5856 ("iavf: rename functions and structs to new
> name")


I believe this commit is more appropriate?
d5b33d024496 ("i40evf: add ndo_setup_tc callback to i40evf")


> Signed-off-by: Ashwin Vijayavel <ashwin.vijayavel@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>

