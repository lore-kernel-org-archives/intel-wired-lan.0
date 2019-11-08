From: Timur Tabi <timur@kernel.org>
Date: Thu, 7 Nov 2019 20:57:33 -0600
Subject: [Intel-wired-lan] [PATCH net-next 2/2] net: qcom/emac: Demote
 MTU change print to debug
In-Reply-To: <20191107223537.23440-3-f.fainelli@gmail.com>
References: <20191107223537.23440-1-f.fainelli@gmail.com>
 <20191107223537.23440-3-f.fainelli@gmail.com>
Message-ID: <dfd60aa0-59e1-5b68-d8ea-61dc3a29ff8e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/7/19 4:35 PM, Florian Fainelli wrote:
> Changing the MTU can be a frequent operation and it is already clear
> when (or not) a MTU change is successful, demote prints to debug prints.
> 
> Signed-off-by: Florian Fainelli<f.fainelli@gmail.com>

Acked-by: Timur Tabi <timur@kernel.org>

