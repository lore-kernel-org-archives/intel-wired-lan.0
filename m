From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 20 Jan 2021 01:29:40 +0000
Subject: [Intel-wired-lan] [PATCH net v4 1/2] i40e: Revert "i40e: don't
 report link up for a VF who hasn't enabled queues"
In-Reply-To: <20210118193454.275037-2-arkadiusz.kubalewski@intel.com>
References: <20210118193454.275037-1-arkadiusz.kubalewski@intel.com>
 <20210118193454.275037-2-arkadiusz.kubalewski@intel.com>
Message-ID: <a1480517830b533099bf5ce90e09a9fd5c00504e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-01-18 at 19:34 +0000, Arkadiusz Kubalewski wrote:
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> This reverts commit 2ad1274fa35ace5c6360762ba48d33b63da2396c

Can you provide more info on why we are reverting? Some of the
information from the cover letter would probably be useful here.

> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---

