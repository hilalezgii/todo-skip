package skip.todo

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import skip.ui.ComposeContext
import skip.ui.ContentComposer

@androidx.annotation.Keep
class BarChartComposer(private val inProgressCount: Int, private val doneCount: Int) : ContentComposer {

    @Composable
    override fun Compose(context: ComposeContext) {
        val maxVal = maxOf(inProgressCount, doneCount, 1)
        val ipHeight = (inProgressCount.toFloat() / maxVal.toFloat() * 64f + 16f).dp
        val doneHeight = (doneCount.toFloat() / maxVal.toFloat() * 64f + 16f).dp

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 48.dp, vertical = 12.dp),
            horizontalArrangement = Arrangement.SpaceEvenly,
            verticalAlignment = Alignment.Bottom
        ) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Text(text = "$inProgressCount", color = Color.White, fontSize = 15.sp)
                Spacer(modifier = Modifier.height(4.dp))
                Box(modifier = Modifier.height(80.dp), contentAlignment = Alignment.BottomCenter) {
                    Box(
                        modifier = Modifier
                            .width(56.dp)
                            .height(ipHeight.coerceAtMost(80.dp))
                            .background(Color(0xFF1A8CFF))
                    )
                }
                Spacer(modifier = Modifier.height(6.dp))
                Text(text = "Todo", color = Color.White, fontSize = 12.sp)
            }
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Text(text = "$doneCount", color = Color.White, fontSize = 15.sp)
                Spacer(modifier = Modifier.height(4.dp))
                Box(modifier = Modifier.height(80.dp), contentAlignment = Alignment.BottomCenter) {
                    Box(
                        modifier = Modifier
                            .width(56.dp)
                            .height(doneHeight.coerceAtMost(80.dp))
                            .background(Color(0xFF33D973))
                    )
                }
                Spacer(modifier = Modifier.height(6.dp))
                Text(text = "Done", color = Color.White, fontSize = 12.sp)
            }
        }
    }
}
