From: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 10 Sep 2020 12:16:33 +0200
Subject: [Intel-wired-lan] [trivial PATCH] treewide: Convert switch/case
 fallthrough; to break; 
In-Reply-To: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
Message-ID: <81d852d4-115f-c6c6-ef80-17c47ec4849a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 09/09/2020 22:06, Joe Perches wrote:
> diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
> index 09f931d4598c..778be26d329f 100644
> --- a/drivers/net/wireless/mediatek/mt7601u/dma.c
> +++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
> @@ -193,11 +193,11 @@ static void mt7601u_complete_rx(struct urb *urb)
>   	case -ESHUTDOWN:
>   	case -ENOENT:
>   		return;
> +	case 0:
> +		break;
>   	default:
>   		dev_err_ratelimited(dev->dev, "rx urb failed: %d\n",
>   				    urb->status);
> -		fallthrough;
> -	case 0:
>   		break;
>   	}
>   
> @@ -238,11 +238,11 @@ static void mt7601u_complete_tx(struct urb *urb)
>   	case -ESHUTDOWN:
>   	case -ENOENT:
>   		return;
> +	case 0:
> +		break;
>   	default:
>   		dev_err_ratelimited(dev->dev, "tx urb failed: %d\n",
>   				    urb->status);
> -		fallthrough;
> -	case 0:
>   		break;
>   	}

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
