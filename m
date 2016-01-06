From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 6 Jan 2016 15:48:46 -0500
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Fix for RAR0 not
 being set to default MAC addr
In-Reply-To: <1452110729-15659-1-git-send-email-tushar.n.dave@oracle.com>
References: <1452110729-15659-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <20160106204846.GE23622@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (01/06/16 12:05), Tushar Dave wrote:

> commit c9f53e63c208 ("ixgbe: Refactor MAC address configuration code")
> introduced code that doesn't set HW register RAR0 to default mac address
> but FF:FF:FF:FF:FF:FF. Due to this, ixgbe HW discards all incoming packets
> that doesn't have destination mac address equals to FF:FF:FF:FF:FF:FF.
> 
> This commit sets RAR0 correctly to default HW mac address.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>

Tested-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

